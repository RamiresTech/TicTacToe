extends TextureRect
class_name RandomBackground


var imageFolder = "res://assets/BG/"
var imageFiles = []

func _ready():
	select_a_random_image()


func select_a_random_image():
	load_image_files()

	if imageFiles.size() > 0:
		var randomIndex = randi() % imageFiles.size()
		var randomImage = imageFiles[randomIndex]

		var random_texture = load(randomImage)
		self.texture = random_texture

func load_image_files():
	var dir = DirAccess.open(imageFolder)

	if dir:
		dir.list_dir_begin()
		var file = dir.get_next()
		while file != "":
			if file.get_extension().to_lower() in ["import"]:
				file = file.replace(".import", "")
				imageFiles.append(imageFolder.path_join(file))

			file = dir.get_next()

		dir.list_dir_end()
	else:
		print("Erro ao abrir a pasta de imagens.")
