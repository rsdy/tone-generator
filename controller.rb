#!/usr/bin/ruby1.8

require 'rubygems'
require 'Qt'

module Keyboard
	class PassThru < Qt::Object
		def [](i) return i end
	end
	Layout = [
		#F1
		PassThru.new,
		#F2
		{#top
		'q' => 'q', '2' => '2', 'w' => 'w',	'3' => '3',	'e' => 'e',	'r' => 'r',
		'5' => '5',	't' => 't',	'6' => '6',	'y' => 'z',	'7' => 's',	'u' => 'x',
		#bottom
		'z' => 'u', 's' => '8',	'x' => 'i',	'd' => '9',	'c' => 'o',	'v' => 'p',
		'g' => '-', 'b' => '[',	'h' => '=',	'n' => 'm',	'j' => 'k',	'm' => ',',
		#functions
		']' => 'f',	'\\' => 'l', ';' => 'v', '\'' => 'g',
		'.' => '/', '/' => '\'', '=' => '\\' },
		#F3
		{#top
		'q' => 'q', '2' => '2',	'w' => 'w',	'3' => '3',	'e' => 'e',	'r' => 'r',
		'5' => '5',	't' => 't',	'6' => '6',	'y' => 'z',	'7' => 's',	'u' => 'x',
		#bottom
		'z' => 'gqv', 's' => 'g2v',	'x' => 'gwv', 'd' => 'g3v',	'c' => 'gev',
		'v' => 'grv', 'g' => 'g5v', 'b' => 'gtv', 'h' => 'g6v',	'n' => 'gzv',
		'j' => 'gsv', 'm' => 'gxv',
		#functions
		']' => 'f',	';' => 'v',	'\'' => 'g' },
		#F4
		{#top
		'q' => 'u',	'2' => '8',	'w' => 'i',	'3' => '9',	'e' => 'o',	'r' => 'p',
		'5' => '-', 't' => '[',	'6' => '=',	'y' => 'm',	'7' => 'k',	'u' => ',',
		#bottom
		'z' => '\'u-', 's' => '\'8-', 'x' => '\'i-', 'd' => '\'9-',	'c' => '\'o-',
		'v' => '\'p-', 'g' => '\'--', 'b' => '\'[-', 'h' => '\'=-',	'n' => '\'m-',
		'j' => '\'k-', 'm' => '\',-',
		#functions
		']' => 'l',	';' => '/',	'\'' => '\'' }
	]
end

class EventFilter < Qt::Object
	attr_writer :serial
	def eventFilter(object, event)
		return false unless Qt::KeyEvent === event
		@keymap ||= Keyboard::Layout[0]

		if event.key >= Qt::Key_F1 and event.key <= Qt::Key_F4
			@keymap = Keyboard::Layout[event.key - 0x01000030]

			return true
		end
		
		key = event.text.strip
		@serial.print @keymap[key] if key != ''
		@serial.flush

		return true
	end
end

class Main < Qt::Widget
	def initialize(filter, parent = nil)
		super(parent)

		line = Qt::LineEdit.new(self)
		line.installEventFilter filter
	end
end

app = Qt::Application.new(ARGV)
File.open(ARGV[0], 'w') do |file|
	filter = EventFilter.new
	filter.serial = file

	window = Main.new filter
	window.show
	app.exec
	file.close
end
