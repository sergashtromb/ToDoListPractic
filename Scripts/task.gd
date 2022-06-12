extends Control


var name_tk = 'Новая задача' 
var priory = 0 
var status = "Выполняется" 
var time = "10:10:2022 16:48" 

func _process(delta):
	$name_task.text = name_tk 
	$Label.text = "Приоритет: " + str(priory) 
	$status.text = "Статус: " + status
	$Label2.text = "Время добавления: " + time 
	if $CheckBox.pressed == true:
		status = "Завершенно" 
	else:
		status = "Выполняется"


func _on_CheckBox_pressed():
	if $CheckBox.pressed == true:
		G.data_task[name]['status'] = "Завершенно"
	else:
		G.data_task[name]['status'] = "Выполняется"
