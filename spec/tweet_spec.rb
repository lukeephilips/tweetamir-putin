require('spec_helper')

describe('retrieves tweet text content') do
  it('runs a .text method successfully') do
    expect($twitter_client.user_timeline("cclifford3120").first.text).to(eq("This is a test of the ruby gem!"))
  end
end
