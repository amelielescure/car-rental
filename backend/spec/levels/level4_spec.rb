require 'spec_helper'

describe 'Level 4' do
  describe '#new' do
    before(:all) do
      LevelFour.run
    end

		include_examples 'Levels', 'app/levels/level4'
	end
end
