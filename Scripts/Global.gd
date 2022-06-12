extends Node



var active_list = 'main'


# словарь для сохранений проектов
var data_project = {}
# словарь для сохранения задач 
var data_task = {}
var main = null
# добавление нового проекта
func add_project(key, priory):
	data_project[key] = {
		"key": key,
		"priory": priory
	}
# удаление проекта
func delet_project(key):
	data_project.erase(key) 
# добавление задачи
func add_task(key, title, priory, time, status, desc, proj):
	data_task[key] = {
		"key": key,
		"title": title,
		"priory": priory,
		"time": time, 
		"status": status,
		"description": desc,
		"project": proj
	}
# удаление задачи
func delet_task(key):
	data_task.erase(key)

# сохранение данных
func save_data():
	var data = {}
	data["projects"] = data_project 
	data["tasks"] = data_task 
	var file = File.new() 
	file.open("user://save.dat", File.WRITE) 
	file.store_var(data) 
	file.close() 
	
	
# загрузка файлов
func load_data():
	var file = File.new() 
	file.open("user://save.dat", File.READ) 
	if file.file_exists("user://save.dat"):
		var data = file.get_var() 
		if data != null:
			data_project = data.projects 
			data_task = data.tasks 
			main.load_projects()
	file.close() 

func clear_data():
	data_project = {} 
	data_task = {}
