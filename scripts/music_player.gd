extends Node

const NORMAL_MUSIC_VOLUME: float = -20
const MINIMUM_MUSIC_VOLUME:float = -80
const TRANSITION_TIME: float = 3
const MUSICS_FOLDER_PATH: String = "res://assets/sounds/musics/"

var music_player: AudioStreamPlayer
var actual_music: String

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)

func play_random_music() -> void:
	var music = __get_random_wav_file_from_folder()
	__change_music(music)

func __get_random_wav_file_from_folder() -> String:
	var dir = DirAccess.open(MUSICS_FOLDER_PATH)

	var wav_files = []
	dir.list_dir_begin()
	var file_path = dir.get_next()

	while file_path != "":
		if file_path.get_extension().to_lower() == "wav":
			wav_files.append(file_path)
		file_path = dir.get_next()

	if wav_files.size() <= 0:
		print("No WAV files found in folder:", MUSICS_FOLDER_PATH)
		return ""

	var random_index = randi() % wav_files.size()
	return MUSICS_FOLDER_PATH + wav_files[random_index]

func __change_music(new_music: String):
	actual_music = new_music.replace(".wav", "")
	var tween = get_tree().create_tween()
	if music_player.playing:
		for i in range(60):
			music_player.volume_db -= 1
			await get_tree().create_timer(0.025).timeout
		music_player.stream = load(new_music)
		for i in range(60):
			music_player.volume_db += 1
			await get_tree().create_timer(0.025).timeout
	else:
		music_player.stream = load(new_music)
		music_player.volume_db = NORMAL_MUSIC_VOLUME
	music_player.play()
