import customtkinter
from utils import app

heading = customtkinter.CTkLabel(app, text='Hosts', font=('Inter', 25))
heading.pack(pady=25)

def btn_click():
    print("Clicked")

frame = customtkinter.CTkFrame(app)
frame.columnconfigure(0)
frame.pack(padx=20, pady=20)
for row in range(3):
    for col in range(3):
        send_button = customtkinter.CTkButton(
            frame, text=f'Host {row+col}', command=btn_click, width=80, height=40, hover_color="orange", border_color="white", border_width=2)
        send_button.grid(row=row, column=col, padx=10, pady=10)

back_btn = customtkinter.CTkButton(app, text='Back', command=btn_click, fg_color="transparent", height=40)
back_btn.pack(pady=40)

app.mainloop()
