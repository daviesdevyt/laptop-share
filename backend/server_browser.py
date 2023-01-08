import socket, time, json
import threading


class ServerBrowser():

    known_servers = {}
    socket_close = False

    def __init__(self) -> None:
        threading.Thread(target=self.remove_dull_servers).start()
        self.detect_servers()

    def remove_dull_servers(self):
        while not self.socket_close:
            for server in self.known_servers.copy():
                if time.time()-self.known_servers[server]["time"] > 3:
                    self.known_servers.pop(server)
            time.sleep(1)

    def detect_servers(self):
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        sock.bind(('0.0.0.0', 9999))
        threading.Thread(target=self.recieve_server_info, args=(sock,)).start()
    
    def recieve_server_info(self, sock):
        while not self.socket_close:
            server_details, addr = sock.recvfrom(1024)
            server_details = json.loads(server_details.decode())
            self.known_servers[addr] = server_details
        sock.close()
    
    def get_servers(self):
        return self.known_servers

    def close(self):
        self.socket_close = True
