import customtkinter

window_size = "360x520"
title = "Laptop Share"

customtkinter.set_appearance_mode("System")
customtkinter.set_default_color_theme("blue")

app = customtkinter.CTk()
app.geometry(window_size)
app.title(title)
app.minsize(360, 520)