require 'rails_helper'

RSpec.describe MenuItemsController do
    describe 'GET' do
        it 'should return all menu items' do
            FactoryBot.create(:menu_item)

            get :index

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            expect(response).to have_http_status(:ok)
            expect(parsed_response.size).to eq(1)
            expect(parsed_response[0]).to include(name: 'Nasi Goreng')
        end

        it 'should return menu item' do
            menu_item = FactoryBot.create(:menu_item)

            get :show, params: { id: menu_item.id }

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            expect(response).to have_http_status(:ok)
            expect(parsed_response).to include(name: 'Nasi Goreng')
        end
    end

    describe 'POST' do
        it 'should return created menu item' do
            FactoryBot.create(:category)
            FactoryBot.create(:menu_item)

            post :create, params: { 
                menu_item: { 
                    name: "Indomie",
                    description: "Indonesian Noodle",
                    price: 10000.0,
                    menu_categories_attributes: [
                        {
                            category_id: 1
                        }
                    ]
                } 
            }

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            expect(parsed_response).to include(name: 'Indomie')
        end
    end

    describe 'PATCH' do
        it 'should return updated menu item' do
            FactoryBot.create(:menu_item)

            patch :update, params: { id: 1, 
                menu_item: { 
                    name: "Indomie Rebus",
                    description: "Indonesian Noodle",
                    price: 15000.0
                } 
            }

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            expect(parsed_response).to include(name: "Indomie Rebus")
        end
    end

    describe 'DELETE' do
        it 'should return message delete' do
            FactoryBot.create(:menu_item)

            delete :destroy, params: { id: 1 }

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            expect(parsed_response).to include(message: "Menu Item was successfully destroyed.")
        end
    end
end