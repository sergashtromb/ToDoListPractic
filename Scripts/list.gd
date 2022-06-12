extends Control

# имя и приоритет проекта
var name_project = 'Новый проект' 
var priory = 0 
var all_tk = 0 
var vic_tk = 0 
var work_tk = 0
func _process(delta):
	$name.text = name_project 
	$priory.text = "Приоритет: " + str(priory)
	$info/all.text = 'Всего задач: ' + str(all_tk) 
	$info/victory.text = 'Выполненно задач: ' + str(vic_tk) 
	$info/work.text = 'Осталось задач: ' + str(work_tk)

func _on_Button_pressed():
	if Input.is_action_just_released("left_m"): 
		G.active_list = name 
		G.main.get_node("work_place/header/name_pos").text = name_project
		G.main.clear_scroll()
		G.main.load_tasks()

func find_task(name_project): 
	var tasks = G.data_task.keys() 
	if tasks != []:
		for i in tasks:
			if G.data_task[i]['project'] == name_project:
				all_tk += 1 
				if G.data_task[i]['status'] == 'Выполняется':
					work_tk += 1 
				elif G.data_task[i]['status'] == 'Завершенно':
					vic_tk += 1
