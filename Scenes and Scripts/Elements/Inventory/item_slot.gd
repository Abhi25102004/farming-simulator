extends PanelContainer
@onready var texture_rect: TextureRect = %TextureRect

func display_icon(item:Item):
	texture_rect.texture=item.icon
