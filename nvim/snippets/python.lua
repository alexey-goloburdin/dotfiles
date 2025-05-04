local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- def
  s("def", {
    t("def "), i(1, "func_name"), t("("), i(2, ""), t({"):", "\t"}), i(3, "pass")
  }),

  -- print
  s("pr", {
    t("print("), i(1, '"Hello, world!"'), t(")")
  }),

  -- pprint
  s("ppr", {
    t('__import__("pprint").pprint('), i(1, 'obj'), t(")")
  }),

  -- log to webhook
  s("wlog", {
    t('webhook_url = "'), i(1, "/webhook-path"), t({'"', "message = str("}),
    i(2, "logging_object"),
    t({")",
       '__import__("tests.lib.log").log(f"Traceback:\\n\\n{__import__(\'traceback\').format_exc()}\\n\\nMessage:\\n\\n{message}", "{webhook_url}")'
    })
  }),
}

