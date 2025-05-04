# frozen_string_literal: true

require 'discordrb'
require 'dotenv'
require_relative "#{__dir__}/../lib/text_lib"

Dotenv.load

WATER_TIME = 3600
REMINDER_CHANNEL = 1_367_992_180_098_072_759

# Bot for Dear Diary server
class DearDiary
  include TextLib

  def initialize
    @bot = Discordrb::Bot.new token: ENV['BOT_TOKEN']
    @command_bot = Discordrb::Commands::CommandBot.new token: ENV['BOT_TOKEN'], prefix: '#'
  end

  def water_timer
    loop do
      sleep WATER_TIME

      users_string = users_mentioned_from_file("#{__dir__}/../data/water_list.txt")

      @bot.send_message(REMINDER_CHANNEL, hydrate_call(users_string))
    end
  end

  def users_mentioned_from_file(_path)
    user_string = ''
    file = File.open("#{__dir__}/../data/water_list.txt", 'r')
    file.each_line do |line|
      user_string += " #{@bot.user(line).mention}"
    end
    user_string
  end

  def commands
    @command_bot.command(:join_hydration_nation, desc: 'Join hydration competition') do |event|
      file = File.open("#{__dir__}/../data/water_list.txt", 'r+')

      exists = file.any? { |line| line.include?(event.user.name) }
      return nil if exists

      file.puts(event.user.id)
      file.close
      "#{event.user.name} has joined Hydration Nation"
    end
  end

  def main
    @bot.run :async
    @command_bot.run :async

    commands
    water_timer
  end
end

bot = DearDiary.new
bot.main
