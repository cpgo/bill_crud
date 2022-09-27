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
      event = event_fixture()
      # test cache
      valid_attrs = %{description: "some description", value: 42, event_id: event.id}

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
      id = bill.id
      assert {:ok, ^id} = Pages.delete_bill(bill)
      assert_raise Ecto.NoResultsError, fn -> Pages.get_bill!(bill.id) end
    end

    test "change_bill/1 returns a bill changeset" do
      bill = bill_fixture()
      assert %Ecto.Changeset{} = Pages.change_bill(bill)
    end
  end

  describe "events" do
    alias BillCrud.Pages.Events

    import BillCrud.PagesFixtures

    @invalid_attrs %{name: nil}

    test "list_events/0 returns all events" do
      events = event_fixture()
      assert Pages.list_events() == [events]
    end

    test "get_events!/1 returns the events with given id" do
      events = event_fixture()
      assert Pages.get_events!(events.id) == events
    end

    test "create_events/1 with valid data creates a events" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Events{} = events} = Pages.create_event(valid_attrs)
      assert events.name == "some name"
    end

    test "create_events/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pages.create_event(@invalid_attrs)
    end

    test "update_events/2 with valid data updates the events" do
      events = event_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Events{} = events} = Pages.update_events(events, update_attrs)
      assert events.name == "some updated name"
    end

    test "update_events/2 with invalid data returns error changeset" do
      events = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Pages.update_events(events, @invalid_attrs)
      assert events == Pages.get_events!(events.id)
    end

    test "delete_events/1 deletes the events" do
      events = event_fixture()
      assert {:ok, %Events{}} = Pages.delete_events(events)
      assert_raise Ecto.NoResultsError, fn -> Pages.get_events!(events.id) end
    end

    test "change_events/1 returns a events changeset" do
      events = event_fixture()
      assert %Ecto.Changeset{} = Pages.change_events(events)
    end
  end
end
