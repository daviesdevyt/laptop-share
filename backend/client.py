import socket, threading, json, math

class ServerReciever():
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    PORT = 10000
    progress = 0

    def __init__(self, ip) -> None:
        self.sock.connect((ip, self.PORT))
        threading.Thread(target=self.build_file).start()

    def build_file(self):
        while True:
            file_details = json.loads(self.sock.recv(1024).decode())
            file = open(file_details["name"], "wb")
            filebytes = b""
            while True:
                data = self.sock.recv(buffer_size)
                buffer_size = 1024*math.floor(file_details["size"]/1000)
                buffer_size = min(buffer_size, 1024*10000)
                data = self.sock.recv(buffer_size)
                if filebytes[-5:] == b"<END>":
                    break
                filebytes += data
                self.progress += buffer_size
            file.write(filebytes)
            file.close()
    
    def get_progress(self):
        return self.progress

