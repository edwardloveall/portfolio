require 'rails_helper'

RSpec.describe PostsController do
  it 'renders the blog layout' do
    get :index

    expect(response).to render_template(:blog)
  end

  describe 'GET #index' do
    it 'assigns all posts as @posts' do
      post = create(:post)

      get :index

      expect(assigns(:posts)).to eq([post])
    end

    context 'pagination' do
      it 'returns maximum 10 posts' do
        posts = create_list(:post, 10)
        create(:post)

        get :index

        expect(assigns(:posts)).to eq(posts)
      end

      it 'returns posts from a page offset' do
        create_list(:post, 10)
        post = create(:post)

        get :index, page: 2

        expect(assigns(:posts)).to eq([post])
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested post as @post' do
      post = create(:post)

      get :show, id: post.id

      expect(assigns(:post)).to eq(post)
    end
  end
end
