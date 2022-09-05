* Crud scaffold
* Install and setup rails/turbo (js) and phoenix_turbo (mix)

No need for extra setup for basic form submition
Submit is hijacked and if the action returns a 303 (redirect) turbo will follow that redirect and replace the whole body




-----
Crappy idea on how to glue togeter views/components to dynamicaly render and concat streams
```
rendered_show = BillCrudWeb.BillView.render("show.html", %{conn: BillCrudWeb.Endpoint, bill: %BillCrud.Pages.Bill{id: 123, description: "shiet", value: 8888}})
inner_block = %{inner_block: fn(_,_) -> rendered_show  end}
BillCrudWeb.Components.TurboStreamComponent.stream_tag(%{action: "create", target: "something", inner_block: inner_block})
|> Phoenix.HTML.Safe.to_iodata()
|> IO.iodata_to_binary()
```
