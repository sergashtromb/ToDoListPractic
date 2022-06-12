extends Control


var elem 
var pop_new_prj
func _ready():
	G.main = self
	pop_new_prj = $Popup
	elem = load("res://Scenes/list.tscn") 
	G.active_list = 'main'
	#G.load_data()




func _on_add_pressed():
	if G.active_list == 'main': 
		$work_place/header/name_pos.text = "Проекты"
		pop_new_prj.popup()
	elif 'list' in G.active_list:
		$Popup_task.popup()

# добавление новго проекта в Popup
func _on_pop_add_pressed():
	$work_place/body/ScrollContainer/VBoxContainer.add_child(elem.instance()) 
	$work_place/body/ScrollContainer/VBoxContainer.get_child(len($work_place/body/ScrollContainer/VBoxContainer.get_children()) - 1).name_project = pop_new_prj.get_node("LineEdit").text 
	$work_place/body/ScrollContainer/VBoxContainer.get_child(len($work_place/body/ScrollContainer/VBoxContainer.get_children()) - 1).priory = pop_new_prj.get_node("SpinBox").value
	G.add_project(pop_new_prj.get_node("LineEdit").text, pop_new_prj.get_node("SpinBox").value)
	pop_new_prj.hide()



func load_projects():
	var children = G.data_project.keys() 
	if children != []:
		for i in children:
			$work_place/body/ScrollContainer/VBoxContainer.add_child(elem.instance()) 
			$work_place/body/ScrollContainer/VBoxContainer.get_child(len($work_place/body/ScrollContainer/VBoxContainer.get_children()) - 1).name_project = G.data_project[i].key
			$work_place/body/ScrollContainer/VBoxContainer.get_child(len($work_place/body/ScrollContainer/VBoxContainer.get_children()) - 1).priory = G.data_project[i].priory
			$work_place/body/ScrollContainer/VBoxContainer.get_child(len($work_place/body/ScrollContainer/VBoxContainer.get_children()) - 1).find_task($work_place/body/ScrollContainer/VBoxContainer.get_child(len($work_place/body/ScrollContainer/VBoxContainer.get_children()) - 1).name)

func load_tasks():
	var children = G.data_task.keys()
	var a = [] 
	if children != []:
		for i in children:
			if G.data_task[i]["project"] == G.active_list:
				a.append(i) 
		
		for i in a:
			$work_place/body/ScrollContainer/VBoxContainer.add_child(load("res://Scenes/task.tscn").instance())
			$work_place/body/ScrollContainer/VBoxContainer.get_child(len($work_place/body/ScrollContainer/VBoxContainer.get_children()) - 1).name_tk = G.data_task[i]['title']
			$work_place/body/ScrollContainer/VBoxContainer.get_child(len($work_place/body/ScrollContainer/VBoxContainer.get_children()) - 1).priory = G.data_task[i]['priory']
			$work_place/body/ScrollContainer/VBoxContainer.get_child(len($work_place/body/ScrollContainer/VBoxContainer.get_children()) - 1).time = G.data_task[i]['time'] 
			$work_place/body/ScrollContainer/VBoxContainer.get_child(len($work_place/body/ScrollContainer/VBoxContainer.get_children()) - 1).status = G.data_task[i]['status']
			if G.data_task[i]['status'] == 'Выполняется':
				$work_place/body/ScrollContainer/VBoxContainer.get_child(len($work_place/body/ScrollContainer/VBoxContainer.get_children()) - 1).get_node('CheckBox').pressed = false
			else:
				$work_place/body/ScrollContainer/VBoxContainer.get_child(len($work_place/body/ScrollContainer/VBoxContainer.get_children()) - 1).get_node('CheckBox').pressed = true


func _on_save_pressed():
	G.save_data()
	$AnimationPlayer.play("save")



func clear_scroll():
	var scroll = $work_place/body/ScrollContainer/VBoxContainer
	for i in range(0, len(scroll.get_children())):
		scroll.get_child(i).queue_free()


func _on_add_task_pressed():
	var task = load("res://Scenes/task.tscn")
	var scroll = $work_place/body/ScrollContainer/VBoxContainer 
	scroll.add_child(task.instance()) 
	scroll.get_child(len(scroll.get_children()) - 1).name_tk = $Popup_task/nm_edit.text
	scroll.get_child(len(scroll.get_children()) - 1).priory = $Popup_task/SpinBox.value 
	scroll.get_child(len(scroll.get_children()) - 1).time = ""+ str(OS.get_datetime()['day'])+":"+str(OS.get_datetime()['month'])+":"+str(OS.get_datetime()["year"]) + " " + str(OS.get_datetime()['hour']) + ":" + str(OS.get_datetime()['minute'])
	G.add_task(scroll.get_child(len(scroll.get_children()) - 1).name, $Popup_task/nm_edit.text, $Popup_task/SpinBox.value, ""+ str(OS.get_datetime()['day'])+":"+str(OS.get_datetime()['month'])+":"+str(OS.get_datetime()["year"]) + " " + str(OS.get_datetime()['hour']) + ":" + str(OS.get_datetime()['minute']), "Выполняется", $Popup_task/TextEdit.text, G.active_list)
	$Popup_task.hide()



func _on_back_pressed():
	if G.active_list != 'main':
		clear_scroll()
		G.active_list = 'main'
		load_projects()
