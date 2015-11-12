require 'rails_helper'

describe 'Video uploading' do
  let(:user) { create(:user, password: '12345678') }
  let(:video) { Rack::Test::UploadedFile.new('./spec/fixtures/video-07.MOV', 'video/quicktime') }

  it 'allows to create a post with video' do
    token = sign_in_as_user(password: '12345678', email: user.email)

    post "/posts",
     post: {title: 'New beach', body: 'I have found a nice beach', video: video},
     authentication_token: token
    expect(response.code).to eq '201'

    get "/posts/#{Post.last.id}", authentication_token: token
    expect(response.code).to eq '200'
  end

  it 'allows to download the video' do
    token = sign_in_as_user(password: '12345678', email: user.email)

    post "/posts",
     post: {title: 'New beach', body: 'I have found a nice beach', video: video},
     authentication_token: token
    expect(response.code).to eq '201'

    get "/posts/#{Post.last.id}/video", authentication_token: token
    expect(response.code).to eq '200'
  end
end
