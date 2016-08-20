require 'spec_helper'

describe 'Level 1' do
	describe '#new' do
		before(:all) do
			LevelOne.new
		end

		include_examples 'Levels', 'app/levels/level2'
	end
end