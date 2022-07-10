defmodule BillCrud.PagesTest do
  use BillCrud.DataCase

  alias BillCrud.Pages

  describe "bills" do
    alias BillCrud.Pages.Bill

    import BillCrud.PagesFixtures

    @invalid_attrs %{description: nil, value: nil}

    test "list_bills/0 returns all bills" do
      bill = bill_fixture()
      assert Pages.list_bills() == [bill]
    end

    test "get_bill!/1 returns the bill with given id" do
      bill = bill_fixture()
      assert Pages.get_bill!(bill.id) == bill
    end

    test "create_bill/1 with valid data creates a bill" do
      valid_attrs = %{description: "some description", value: 42}

      assert {:ok, %Bill{} = bill} = Pages.create_bill(valid_attrs)
      assert bill.description == "some description"
      assert bill.value == 42
    end

    test "create_bill/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pages.create_bill(@invalid_attrs)
    end

    test "update_bill/2 with valid data updates the bill" do
      bill = bill_fixture()
      update_attrs = %{description: "some updated description", value: 43}

      assert {:ok, %Bill{} = bill} = Pages.update_bill(bill, update_attrs)
      assert bill.description == "some updated description"
      assert bill.value == 43
    end

    test "update_bill/2 with invalid data returns error changeset" do
      bill = bill_fixture()
      assert {:error, %Ecto.Changeset{}} = Pages.update_bill(bill, @invalid_attrs)
      assert bill == Pages.get_bill!(bill.id)
    end

    test "delete_bill/1 deletes the bill" do
      bill = bill_fixture()
      assert {:ok, %Bill{}} = Pages.delete_bill(bill)
      assert_raise Ecto.NoResultsError, fn -> Pages.get_bill!(bill.id) end
    end

    test "change_bill/1 returns a bill changeset" do
      bill = bill_fixture()
      assert %Ecto.Changeset{} = Pages.change_bill(bill)
    end
  end
end
