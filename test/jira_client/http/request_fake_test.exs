defmodule JiraClient.Http.RequestFakeTest do
  use ExUnit.Case

  alias JiraClient.Http.RequestFake

  describe "managemnt" do

    test "start" do
      assert :ok == RequestFake.init()
    end

    test "start twice" do
      assert :ok == RequestFake.init()
      assert :ok == RequestFake.init()
    end

    test "default response" do
      RequestFake.init()

      assert "" == RequestFake.next_response()
    end
  end

  describe "store and retrieve responses" do

    test "expect response" do
      RequestFake.init()
      RequestFake.expect_response("response1")

      assert "response1" == RequestFake.next_response()
    end
    
    test "expect a sequence of responses" do
      RequestFake.init()
      RequestFake.expect_response("response1")
      RequestFake.expect_response("response2")

      assert "response1" == RequestFake.next_response()
      assert "response2" == RequestFake.next_response()
      assert "" == RequestFake.next_response()
    end

    test "expect a longer  sequence of responses" do
      RequestFake.init()
      RequestFake.expect_response("response1")
      RequestFake.expect_response("response2")
      RequestFake.expect_response("response3")
      RequestFake.expect_response("response4")
      RequestFake.expect_response("response5")

      assert "response1" == RequestFake.next_response()
      assert "response2" == RequestFake.next_response()
      assert "response3" == RequestFake.next_response()
      assert "response4" == RequestFake.next_response()
      assert "response5" == RequestFake.next_response()
      assert "" == RequestFake.next_response()
    end

    test "clear expeted results" do
      RequestFake.init()
      RequestFake.expect_response("response1")

      RequestFake.clear()

      assert "" == RequestFake.next_response()
    end

    test "sequence polution ensure init clears" do
      RequestFake.init()
      RequestFake.expect_response("response1")

      RequestFake.init()
      RequestFake.expect_response("response2")

      assert "response2" == RequestFake.next_response()
    end

    test "no expected response will return no response" do
      RequestFake.init()

      assert "" == RequestFake.next_response()
    end
  end

  describe "remember and return requests" do
    test "capture and reutrn a request" do
      RequestFake.init()

      request = RequestFake.new(:get, "body", "path")
      RequestFake.send(request)

      assert {:get, "body", "path"} == RequestFake.next_request()
    end

    test "capture 2 requests and reutrn a request" do
      RequestFake.init()

      RequestFake.send(RequestFake.new(:get, "body", "path"))
      RequestFake.send(RequestFake.new(:post, "{}", "/rest/api/projects"))

      assert {:get, "body", "path"} == RequestFake.next_request()
      assert {:post, "{}", "/rest/api/projects"} == RequestFake.next_request()
    end

    test "get nothing when no requests have been sent" do
      RequestFake.init()

      assert {:none, "", ""} == RequestFake.next_request()
    end
  end
end

