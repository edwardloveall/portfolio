require 'rails_helper'

RSpec.describe PostsController do
  it 'renders the blog layout' do
    get :index

    expect(response).to render_template(:blog)
  end

  describe 'GET #index' do
    context 'in html format' do
      it 'assigns all posts as @posts' do
        post = create(:post)

        get :index

        expect(assigns(:posts)).to eq([post])
      end

      context 'pagination' do
        it 'returns maximum 10 posts' do
          create(:post)
          posts = create_list(:post, 10)
          posts.reverse!

          get :index

          expect(assigns(:posts)).to eq(posts)
        end

        it 'returns posts from a page offset' do
          post = create(:post)
          create_list(:post, 10)

          get :index, page: 2

          expect(assigns(:posts)).to eq([post])
        end
      end
    end

    context 'in xml format' do
      it 'uses no base layout' do
        get :index, format: :rss

        expect(response).not_to render_template(:blog)
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested post as @post' do
      post = create(:post)

      get :show, slug: post.slug

      expect(assigns(:post)).to eq(post)
    end
  end
end
