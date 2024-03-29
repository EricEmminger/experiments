require "application_system_test_case"

class FeedsTest < ApplicationSystemTestCase
  setup do
    @feed = feeds(:one)
  end

  test "visiting the index" do
    visit feeds_url
    assert_selector "h1", text: "Feeds"
  end

  test "creating a Feed" do
    visit feeds_url
    click_on "New Feed"

    fill_in "Authors", with: @feed.authors
    fill_in "Format", with: @feed.format
    fill_in "Generator", with: @feed.generator
    fill_in "Published", with: @feed.published
    fill_in "Summary", with: @feed.summary
    fill_in "Tags", with: @feed.tags
    fill_in "Title", with: @feed.title
    fill_in "Updated", with: @feed.updated
    fill_in "Url", with: @feed.url
    click_on "Create Feed"

    assert_text "Feed was successfully created"
    click_on "Back"
  end

  test "updating a Feed" do
    visit feeds_url
    click_on "Edit", match: :first

    fill_in "Authors", with: @feed.authors
    fill_in "Format", with: @feed.format
    fill_in "Generator", with: @feed.generator
    fill_in "Published", with: @feed.published
    fill_in "Summary", with: @feed.summary
    fill_in "Tags", with: @feed.tags
    fill_in "Title", with: @feed.title
    fill_in "Updated", with: @feed.updated
    fill_in "Url", with: @feed.url
    click_on "Update Feed"

    assert_text "Feed was successfully updated"
    click_on "Back"
  end

  test "destroying a Feed" do
    visit feeds_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Feed was successfully destroyed"
  end
end
