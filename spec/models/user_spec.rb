require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation' do
    it 'should fail validation if there is no email'
    end
    it 'should fail validation if there is no first name'
    end
    it 'should fail validation if there is no last name'
    end
    it 'should validate succesfully with a valid user'
    end
    it 'should fail validation when there is no password'
    end
    it 'should fail when there is no password confirmation'
    end
    it 'should fail when password confirmation doesnt match'
    end
    it 'should fail when email already exists (not case sensitive)'
    end
end
