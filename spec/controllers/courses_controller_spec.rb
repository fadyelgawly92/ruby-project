require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
    context 'GET #index' do
        it 'returns a success response' do
            get :index
            expect(response).to be_success #response.success?
        end    
    end 
    
    context 'GET #show' do
        it 'returns a success response' do
            user = User.create!(name: 'ramzy', email: 'ramzy@gmail.com' ,gender: 'male', password: '1234567', password_confirmation: '1234567') 
            course = Course.create!(title: 'javascript' , user_id: '1')
            get :show , params:  { id: course.to_param }
            expect(response).to be_success
        end    
    end
end
