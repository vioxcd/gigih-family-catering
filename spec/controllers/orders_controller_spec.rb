require 'rails_helper'

RSpec.describe OrdersController do
    describe 'GET' do
        it 'should return all order' do
            FactoryBot.create(:order, customer_email: "alvi@gmail.com")

            get :index

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            expect(response).to have_http_status(:ok)
            expect(parsed_response.size).to eq(1)
            expect(parsed_response[0]).to include(customer_email: 'alvi@gmail.com')
        end

        it 'should return all order match with filter' do
            FactoryBot.create(:order, customer_email: "alvi@gmail.com", total_price: 20000, created_at: "2019-01-01")
            FactoryBot.create(:order, customer_email: "alvi@gmail.com", total_price: 15000, created_at: "2019-01-02")
            FactoryBot.create(:order, customer_email: "alvi@gmail.com", total_price: 10000, created_at: "2019-01-03")
            FactoryBot.create(:order, customer_email: "user1@gmail.com", total_price: 5000, created_at: "2019-01-04")

            get :index, params: { email: "alvi@gmail.com", min_price: 10000, max_price: 20000, start_date: "2019-01-01", end_date: "2019-01-03" }

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            expect(response).to have_http_status(:ok)
            expect(parsed_response.size).to eq(2)
            expect(parsed_response[0]).to include(customer_email: 'alvi@gmail.com')
        end

        it 'should return order' do
            order = FactoryBot.create(:order, customer_email: "alvi@gmail.com")

            get :show, params: { id: order.id }

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            expect(response).to have_http_status(:ok)
            expect(parsed_response).to include(customer_email: 'alvi@gmail.com')
        end
    end

    describe 'POST' do
        it 'should return created order' do
            FactoryBot.create(:order, customer_email: "alvi@gmail.com")
            FactoryBot.create(:menu_item)

            post :create, params: { 
                order: { 
                    customer_name: "Alviand",
                    customer_email: "alvi@gmail.com", 
                    total_price: 20000, 
                    created_at: "2019-01-01", 
                    order_details_attributes: [
                        {
                            menu_item_id: 1,
                            quantity: 2 
                        }
                    ] 
                } 
            }

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            expect(parsed_response).to include(customer_email: 'alvi@gmail.com')
        end
    end

    describe 'PATCH' do
        it 'should return updated order' do
            FactoryBot.create(:order)
            FactoryBot.create(:menu_item)

            patch :update, params: { id: 1, order: { 
                customer_name: "Alviand",
                customer_email: "alvi@gmail.com", 
                total_price: 20000,
                status: "PAID", 
                created_at: "2019-01-01", 
                order_details_attributes: [
                    {
                        menu_item_id: 1,
                        quantity: 2 
                    }
                ] 
            } }

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            expect(parsed_response).to include(status: "PAID")
        end
    end

    describe 'DELETE' do
        it 'should return message delete' do
            FactoryBot.create(:order)

            delete :destroy, params: { id: 1 }

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            expect(parsed_response).to include(message: "Order was successfully destroyed.")
        end
    end
end