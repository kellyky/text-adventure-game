#!/bin/bash

# Translating my python text adventure game to shell :D 


function setup_game () {
  dinky_armory=("fountain pen" "dagger" "umbrella" "paintbrush" "magnifying glass")
  mighty_armory=("magical Sword of Ogoroth" "mystical Mirror of Memory" "pugnacious Pug from Pugnasia")
  villain_pool=("tax collector" "evil oceanographer" "inept but evil pirate" "baby shark")

  wimpy_weapon=${dinky_armory[$(( RANDOM % 5 ))]}
  mighty_weapon=${mighty_armory[$(( RANDOM % 3 ))]}
  villain=${villain_pool[$(( RANDOM % 4 ))]}

  ARMED_WITH=$wimpy_weapon
}

function echo_pause (){
  echo -e "$1"
  sleep 0.35
}

function run_intro_script (){
  echo_pause "You find yourself standing in a meadow with grass and wild flowers."
  echo_pause "Rumor has it that a $villain is somewhere around here, and has been terrifying the nearby villagers."
  echo_pause "In front of you is a house."
  echo_pause "In your hand you hold your trusty (but ineffective, given the circumstances) $wimpy_weapon.\n"
}

function choose_house_or_cave () {
  echo_pause "Enter 1 to knock on the door of the house."
  echo_pause "Enter 2 to peer into the cave."
  echo_pause "What would you like to do?"
  echo_pause "(Please enter 1 or 2.)"
  read choice  

  if [[ $choice == 1 ]]; then 
    knock_door 
  elif [[ $choice == 2 ]]; then
    choose_cave 
  else 
    echo_pause "That\'s not an option."
    choose_house_or_cave 
  fi
}

function knock_door () {
  echo_pause "You approach the door of the house."
  echo_pause "You are about to enter and out steps the $villain."
  echo_pause "Eep! This is the $villain's house!"
  echo_pause "The $villain attacks you!"
  if [[ $ARMED_WITH != $mighty_weapon ]]; then
    echo_pause "You feel a little under-prepared, what with only having a $wimpy_weapon."
  fi
  echo_pause "Would you like to (1) fight or (2) run away?"
  read choice
  if [[ $choice == 1 ]]; then
    choose_to_fight
  elif [[ $choice == 2 ]]; then 
    echo_pause "You run back into the field."
    echo_pause "Luckily, you don't seem to have been followed.\n"
    choose_house_or_cave
  else 
    echo_pause "That's not an option."
    choose_house_or_cave
  fi
}

function choose_cave () {
  if [[ $ARMED_WITH == $mighty_weapon ]]; then 
    echo_pause "You've been here before, and gotten all the good stuff. It's just an empty cave now. You walk back out to the field.\n"
    choose_house_or_cave
  else  
    echo_pause "You peer cautiously into the cave."
    echo_pause "It turns out to be a very small cave."
    echo_pause "Your eye catches a glint of metal behind a rock."
    echo_pause "You have found the $mighty_weapon!"
    ARMED_WITH=$mighty_weapon
    echo_pause "You discard your silly $wimpy_weapon and take the sword with you."
    echo_pause "You walk back out to the field.\n"
    choose_house_or_cave
  fi
}

function choose_to_fight (){ 
  if [[ $ARMED_WITH == $mighty_weapon ]]
  then you_win
  else
    you_lose
  fi
}

function you_win (){
  # TODOs create slightly different victory sequences depending on the weapon. 
  echo_pause "As the $villain moves to attach, you ready your new weapon." 
  echo_pause "$ARMED_WITH shines brightly in your hand as you brace yourself for the attach."
  echo_pause "But the $villain takes one look at your shiny new toy and runs away!"
  echo_pause "You have rid the town of the $villain. You are victorious!\n"
  want_to_play_again
}

function you_lose (){
  echo_pause "You do your best..."
  echo_pause "but your $wimpy_weapon is no match for the $villain."
  echo_pause "You have been defeated!"
  want_to_play_again
}

function want_to_play_again(){
  echo_pause "Would you like to play again? y/n"
  read choice
  if [[ $choice == y ]]; then  
    echo_pause "Excellent! Restarting the game..."
    play_game
  elif [[ $choice == n ]]; then
    echo_pause "Thank you for playing! See you next time."
  else 
    echo_pause "That's not an option."
    want_to_play_again
  fi
}

function play_game () {
  setup_game
  run_intro_script
  choose_house_or_cave
}

play_game
