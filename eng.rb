if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end
require 'tk'
require 'tkextlib/tile'
########################
########################
########################
def gg
	$frame_start.pack_forget
	$frame_gg = TkFrame.new($main_menu) do
		background "red"
		padx 15
		pady 20
		pack('side' => 'left')
	end
	gg_page_again = TkButton.new($frame_gg) do
		text "Again"
		pack("side"=>"right", "padx"=> "50", "pady"=> "10")
		pack("side"=>"right", "padx"=> "50", "pady"=> "10")
		command (proc {start})
	end
	gg_page_exit = TkButton.new($frame_gg) do
		text "exit"
		pack("side"=>"right", "padx"=> "50", "pady"=> "10")
		command(proc {exit})
	end
end
########################
########################
########################
$eng_hash = {}
File.foreach('words.txt', encoding: "utf-8") do |line| 
fields = line.split '::'
a = fields[0]
b = fields[1]
$eng_hash[a] = b
end

$keys = $eng_hash.each_key.to_a # Создаем массив из КЛЮЧЕЙ хеша $eng_hash
$values = $eng_hash.each_value.to_a # Создаем массив из ЗНАЧЕНИЙ хеша $eng_hash

$main_menu = TkRoot.new do
	title "Language-path(eng)"
	minsize(400,400)
end
$frame_start = TkFrame.new($main_menu) {}

$start_button = TkButton.new($main_menu) do
	text "start"
	command(proc {start})
	pack("side"=> "left", "padx"=> "30", "pady"=> "5")
end

menu = TkMenu.new($main_menu) # создаём меню
menu.add('command', 'label' => "English") #, 'command' => eng_click
menu.add('command', 'label' => "Español")
menu.add('command', 'label' => "Deutsche")
bar = TkMenu.new
bar.add('cascade', 'menu' => menu, 'label' => "Languages")
$main_menu.menu(bar)

def start
	$start_button.pack_forget
	$frame_start.pack_forget
	key = $keys.sample # Рандомный item из массива $keys
	# (ОЧЕНЬ ВАЖНО) Переменая key является тем самым словом, перевод которого бы будем выбирать в приложении
	true_value = $eng_hash[key] # Правильный перевод

	wrong_value1 = $values.sample
	while wrong_value1 == true_value do
		wrong_value1 = $values.sample
	end
	wrong_value2 = $values.sample
	while wrong_value2 == true_value do
		wrong_value2 = $values.sample
	end
	while wrong_value2 == wrong_value1 do
		wrong_value2 = $values.sample
	end

	# key         	слово
	# true_value	правильный перевод
	# wrong_value1	неправильный перевод
	# wrong_value2	неправильный перевод
	# Запишем все три варианта ответа в один массив
	variables = [true_value, wrong_value1, wrong_value2]
	v1 = variables.sample
	v2 = variables.sample
	while v2 == v1 do
		v2 = variables.sample
	end
	v3 = variables.sample
	while v3 == v1 or v3 == v2 do
		v3 = variables.sample
	end

	if v1 == true_value
		puts "v1"
	end
	if v2 == true_value
		puts "v2"
	end
	if v3 == true_value
		puts "v3"
	end

	$frame_start = TkFrame.new($main_menu) do
		background "red"
		padx 15
		pady 20
		pack('side' => 'left')
	end

	$eng_page_lbl = TkLabel.new($frame_start) do  
		text "English"
	 	pack("padx"=> "0", "pady"=> "10")
	end

	$eng_page_key = TkButton.new($frame_start) do
		text key
		pack('padx'=>0	,'pady'=>30)
	end

	$value1 = TkButton.new($frame_start) do
		text v1
		if v1 == true_value
			command (proc {start})
		end
		if v1 == wrong_value1 or v1 == wrong_value2
			command (proc {gg})
		end
	  	pack("side"=> "left", "padx"=> "30", "pady"=> "5")
	end

	$value2 = TkButton.new($frame_start) do
		text v2
		if v2 == true_value
			command (proc {start})
		end
		if v2 == wrong_value1 or v2 == wrong_value2
			command (proc {gg})
		end
	  	pack("side"=> "left", "padx"=> "30", "pady"=> "5")
	end

	$value3 = TkButton.new($frame_start) do
		text v3
		if v3 == true_value
			command (proc {start})
		end
		if v3 == wrong_value1 or v3 == wrong_value2
			command (proc {gg})
		end
	  	pack("side"=> "left", "padx"=> "30", "pady"=> "5")
	end
	
end



Tk.mainloop