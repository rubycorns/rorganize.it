require 'spec_helper'

describe 'routing to topics' do
  it 'routes create' do
    expect(post: '/groups/:id/topics').to be_routable
  end

  it 'routes edit' do
    expect(get: '/groups/:id/topics/:topic_id/edit').to be_routable
  end

  it 'routes update' do
    expect(put: '/groups/:id/topics/:topic_id').to be_routable
  end

  it 'routes destroy' do
    expect(delete: '/groups/:id/topics/:topic_id').to be_routable
  end

  it 'does not route show' do
    expect(get: '/groups/:id/topics/:topic_id').to_not be_routable
  end

  it 'does not route index' do
    expect(get: '/groups/:id/topics').to_not be_routable
  end
end
