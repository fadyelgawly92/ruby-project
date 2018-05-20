require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do 
    it 'ensures name presence' do
      user = User.new(gender: 'male', email: 'fady@gmail.com').save
      expect(user).to eq(false)
    end 
    
    it 'ensures email presence' do
      user = User.new(gender: 'male', name: 'fady').save
      expect(user).to eq(false)
    end  

    it 'ensures gender presence' do
      user = User.new(name: 'fady', email: 'fady@gmail.com').save
      expect(user).to eq(false)
    end  

    it 'should save successfully' do
      user = User.new(name: 'fady' ,gender: 'male', email: 'fady@gmail.com' , password: '123456', password_confirmation: '123456').save
      expect(user).to eq(true)
    end  
  end

  context 'scope tests' do 
    let! (:params) { {name: 'fady', email: 'fady@gmail.com'} }
    before(:each) do
    User.new(name: 'ramzy', email: 'ramzy@gmail.com' ,gender: 'male', password: '1234567', password_confirmation: '1234567').save
    User.new(name: 'fahmy', email: 'fahmy@gmail.com' ,gender: 'male', password: '1234568', password_confirmation: '1234568').save
    User.new(name: 'fady', email: 'fady@gmail.com' ,gender: 'male', password: '1234569', password_confirmation: '1234569').save
    User.new(name: 'hala', email: 'hala@gmail.com' ,gender: 'female', password: '123457', password_confirmation: '123457').save
    User.new(name: 'yasmin', email: 'yasmin@gmail.com' ,gender: 'female', password: '123458', password_confirmation: '123458').save 
    end 

    it 'should return male users' do
      expect(User.male_users.size).to eq(3)
    end  

    it 'should return female users' do
      expect(User.female_users.size).to eq(2)
    end  
  end
end
