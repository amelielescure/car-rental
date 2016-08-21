require 'spec_helper'

describe 'Level 5' do
  describe '#new' do
    before(:all) do
      LevelFive.run
    end

    include_examples 'Levels', 'app/levels/level5'
  end
end
