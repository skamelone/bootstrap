#!/usr/bin/env ruby

# You can generate json by executing the following command on Terminal.
#
# $ ruby ./yabai.rb
#

# Parameters

def parameters
  {
    :simultaneous_threshold_milliseconds => 500,
    :trigger_key => 'z',
  }
end

############################################################

require 'json'

def main
  data = {
    'title' => 'Numeric Mode',
    'rules' => [
      {
        'description' => 'Numeric mode',
        'manipulators' => [
          generate_launcher_mode('spacebar', [], [{ 'key_code' => "0" }]),
          generate_launcher_mode('m', [], [{ 'key_code' => "1" }]),
          generate_launcher_mode('comma', [], [{ 'key_code' => "2" }]),
          generate_launcher_mode('period', [], [{ 'key_code' => "3" }]),
          generate_launcher_mode('j', [], [{ 'key_code' => "4" }]),
          generate_launcher_mode('k', [], [{ 'key_code' => "5" }]),
          generate_launcher_mode('l', [], [{ 'key_code' => "6" }]),
          generate_launcher_mode('u', [], [{ 'key_code' => "7" }]),
          generate_launcher_mode('i', [], [{ 'key_code' => "8" }]),
          generate_launcher_mode('o', [], [{ 'key_code' => "9" }]),
        ].flatten,
      },
    ],
  }

  puts JSON.pretty_generate(data)
end

def generate_launcher_mode(from_key_code, mandatory_modifiers, to)
  data = []

  ############################################################

  h = {
    'type' => 'basic',
    'from' => {
      'key_code' => from_key_code,
      'modifiers' => {
        'mandatory' => mandatory_modifiers,
        'optional' => [
          'any',
        ],
      },
    },
    'to' => to,
    'conditions' => [
      {
        'type' => 'variable_if',
        'name' => 'numeric_mode',
        'value' => 1,
      },
    ],
  }

  data << h

  ############################################################

  h = {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => parameters[:trigger_key],
        },
        {
          'key_code' => from_key_code,
        },
      ],
      'simultaneous_options' => {
        'detect_key_down_uninterruptedly' => true,
        'key_down_order' => 'strict',
        'key_up_order' => 'strict_inverse',
        'key_up_when' => 'any',
        'to_after_key_up' => [
          {
            'set_variable' => {
              'name' => 'numeric_mode',
              'value' => 0,
            },
          },
        ],
      },
      'modifiers' => {
        'mandatory' => mandatory_modifiers,
        'optional' => [
          'any',
        ],
      },
    },
    'to' => [
      {
        'set_variable' => {
          'name' => 'numeric_mode',
          'value' => 1,
        },
      },
    ].concat(to),
    'parameters' => {
      'basic.simultaneous_threshold_milliseconds' => parameters[:simultaneous_threshold_milliseconds],
    },
  }

  data << h

  ############################################################

  data
end

main
