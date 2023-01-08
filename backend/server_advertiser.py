import os, socket, time, json, threading

class ServerAdvertiser():

    socket_close = False
    server_details = {
        "username": os.getlogin(),
        "time": time.time()
    }

    dest_addr = ('255.255.255.255', 9999)
    
    def __init__(self) -> None:
        self.start_server()

    def start_server(self):
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
        threading.Thread(target=self.broadcast_server).start()

    def broadcast_server(self, sock):
        while not self.socket_close:
            sock.sendto(json.dumps(self.server_details).encode(), self.dest_addr)
            time.sleep(1)
        sock.close()
    
    def close(self):
        self.socket_close = True
