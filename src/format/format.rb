require_relative '../../setup.rb'
require_relative '../compiler/_requires.rb'

stream = DabProgramStream.new(STDIN.read)
compiler = DabCompiler.new(stream)
program = compiler.program

options = {}

program.dump
puts program.formatted_source(options)
