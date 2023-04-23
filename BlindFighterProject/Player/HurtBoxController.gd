extends Node


func idle():
	$HurtBoxLeft.set_status($HurtBoxLeft.Condition.IDLE, $HurtBoxLeft.color["idle"])
	$HurtBoxCenter.set_status($HurtBoxCenter.Condition.IDLE, $HurtBoxCenter.color["idle"])
	$HurtBoxRight.set_status($HurtBoxRight.Condition.IDLE, $HurtBoxLeft.color["idle"])

func dodge_left():
	$HurtBoxLeft.set_status($HurtBoxLeft.Condition.IDLE, $HurtBoxLeft.color["idle"])
	$HurtBoxCenter.set_status($HurtBoxCenter.Condition.IDLE, $HurtBoxCenter.color["idle"])
	$HurtBoxRight.set_status($HurtBoxRight.Condition.INVINCIBLE, $HurtBoxLeft.color["invincible"])

func dodge_right():
	$HurtBoxLeft.set_status($HurtBoxLeft.Condition.INVINCIBLE, $HurtBoxLeft.color["invincible"])
	$HurtBoxCenter.set_status($HurtBoxCenter.Condition.IDLE, $HurtBoxCenter.color["idle"])
	$HurtBoxRight.set_status($HurtBoxRight.Condition.IDLE, $HurtBoxLeft.color["idle"])

func parry():
	$HurtBoxLeft.set_status($HurtBoxLeft.Condition.IDLE, $HurtBoxLeft.color["idle"])
	$HurtBoxCenter.set_status($HurtBoxCenter.Condition.PARRY, $HurtBoxCenter.color["parry"])
	$HurtBoxRight.set_status($HurtBoxRight.Condition.IDLE, $HurtBoxLeft.color["idle"])
