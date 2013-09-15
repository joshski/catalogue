Feature: Search

  Scenario: Find Products By Criteria
    Given there are products
    When I search for products
    Then I should find matching products

  Scenario: View Products
    Given there are products
    When I choose a product
    Then I should see product details
