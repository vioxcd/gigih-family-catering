require 'rails_helper'

RSpec.describe CategoriesController do
    describe 'GET' do
        it 'should return all category' do
            FactoryBot.create(:category, name: "Category 1")
            FactoryBot.create(:category, name: "Category 2")

            get :index

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            expect(response).to have_http_status(:ok)
            expect(parsed_response.size).to eq(2)
        end

        it 'should return category' do
            order = FactoryBot.create(:category, name: "Category 1")

            get :show, params: { id: order.id }

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            expect(response).to have_http_status(:ok)
            expect(parsed_response).to include(name: 'Category 1')
        end
    end

    describe 'POST' do
        it 'should return created category' do
            post :create, params: { 
                category: { 
                    name: "Category 1"
                } 
            }

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            expect(parsed_response).to include(name: 'Category 1')
        end
    end

    describe 'PATCH' do
        it 'should return updated category' do
            FactoryBot.create(:category)

            patch :update, params: { id: 1, 
                category: { 
                    name: "Category 2"
                }  
            }

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            expect(parsed_response).to include(name: "Category 2")
        end
    end

    describe 'DELETE' do
        it 'should return message delete' do
            FactoryBot.create(:category)

            delete :destroy, params: { id: 1 }

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            expect(parsed_response).to include(message: "Category was successfully destroyed.")
        end
    end
end