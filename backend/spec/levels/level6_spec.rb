require 'spec_helper'

describe 'Level 6' do
	describe '#new' do
		before(:all) do
			LevelSix.new
		end

		include_examples 'Levels', 'app/levels/level6'
	end
end