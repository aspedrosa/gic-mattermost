
import copy
import json
import os
import threading

import cherrypy


BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DISCOVERY_FILE_PATH = os.getenv("DISCOVERY_FILE_PATH", os.path.join(BASE_DIR, "snmp_targets.json"))


class MySet:

    def __init__(self):
        self._data = dict()

    def __iter__(self):
        return self._data.keys().__iter__()

    def __len__(self):
        return self._data.__len__()

    def add(self, element):
        count = self._data.get(element, 0)
        if count > 0:
            self._data[element] = count + 1
            return False

        self._data[element] = 1
        return True

    def remove(self, element):
        count = self._data.get(element, 0)
        if count == 1:
            del self._data[element]
            return True
        elif count > 1:
            self._data[element] = count - 1
        else:
            cherrypy.log(f"Trying to remove '{element}' and wasn't associated")

        return False


base_entry = {
    "labels": {
        "job": "snmp",
    },
}


def create_targets(targets):
    content = []
    for target in targets:
        base_entry_copy = copy.copy(base_entry)
        base_entry_copy["targets"] = [target]
        content.append(base_entry_copy)
    return content


class Root(object):

    targets = MySet()
    mutex = threading.RLock()

    @cherrypy.expose
    def attach(self):
        
        self.mutex.acquire()

        try:
            if self.targets.add(cherrypy.request.headers["Remote-addr"]):
                cherrypy.log("updating targets file")
                with open(DISCOVERY_FILE_PATH, "w+") as discovery_file:
                    if len(self.targets) == 0:
                        discovery_file.write("{}")
                    else:
                        discovery_file.write(json.dumps(create_targets(self.targets)))

            return "Added!"
        except Exception:
            cherrypy.log("Something went wrong on attach!", traceback=True)
        finally:
            self.mutex.release()

    @cherrypy.expose
    def detach(self):

        self.mutex.acquire()

        try:
            if self.targets.remove(cherrypy.request.headers["Remote-addr"]):
                cherrypy.log("updating targets file")
                with open(DISCOVERY_FILE_PATH, "w+") as discovery_file:
                    if len(self.targets) == 0:
                        discovery_file.write("[]")
                    else:
                        discovery_file.write(json.dumps(create_targets(self.targets)))

            return "Removed!"
        except Exception:
            cherrypy.log("Something went wrong on detach!", traceback=True)
        finally:
            self.mutex.release()


def main():
    with open(DISCOVERY_FILE_PATH, "w+") as discovery_file:
        discovery_file.write("[]")

    cherrypy.server.socket_host = "0.0.0.0"
    cherrypy.quickstart(Root(), '/')


if __name__ == "__main__":
    main()
