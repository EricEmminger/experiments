require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase
  setup do
    @item = items(:one)
  end

  test "visiting the index" do
    visit items_url
    assert_selector "h1", text: "Items"
  end

  test "creating a Item" do
    visit items_url
    click_on "New Item"

    fill_in "Attachments", with: @item.attachments
    fill_in "Authors", with: @item.authors
    fill_in "Content html", with: @item.content_html
    fill_in "Content text", with: @item.content_text
    fill_in "External url", with: @item.external_url
    fill_in "Guid", with: @item.guid
    fill_in "Published", with: @item.published
    fill_in "Summary", with: @item.summary
    fill_in "Tags", with: @item.tags
    fill_in "Title", with: @item.title
    fill_in "Updated", with: @item.updated
    click_on "Create Item"

    assert_text "Item was successfully created"
    click_on "Back"
  end

  test "updating a Item" do
    visit items_url
    click_on "Edit", match: :first

    fill_in "Attachments", with: @item.attachments
    fill_in "Authors", with: @item.authors
    fill_in "Content html", with: @item.content_html
    fill_in "Content text", with: @item.content_text
    fill_in "External url", with: @item.external_url
    fill_in "Guid", with: @item.guid
    fill_in "Published", with: @item.published
    fill_in "Summary", with: @item.summary
    fill_in "Tags", with: @item.tags
    fill_in "Title", with: @item.title
    fill_in "Updated", with: @item.updated
    click_on "Update Item"

    assert_text "Item was successfully updated"
    click_on "Back"
  end

  test "destroying a Item" do
    visit items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Item was successfully destroyed"
  end
end
