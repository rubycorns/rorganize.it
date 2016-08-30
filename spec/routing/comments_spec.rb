require 'spec_helper'

describe 'routing to comments' do
  it 'routes create' do
    expect(post: '/groups/:group_id/topics/:topic_id/comments').to be_routable
  end

  it 'does not route edit' do
    expect(get: '/groups/:group_id/topics/:topic_id/comments/:id/edit').to_not be_routable
  end

  it 'does not route update' do
    expect(patch: '/groups/:group_id/topics/:topic_id/comments/:id').to_not be_routable
  end

  it 'does not route destroy' do
    expect(delete: '/groups/:group_id/topics/:topic_id/comments/:id').to_not be_routable
  end

  it 'does not route show' do
    expect(get: '/groups/:group_id/topics/:topic_id/comments/:id').to_not be_routable
  end

  it 'does not route index' do
    expect(get: '/groups/:group_id/topics/:topic_id/comments/').to_not be_routable
  end
end
