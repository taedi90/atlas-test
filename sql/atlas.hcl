env "common" {
  migration {
    dir = "file://common"
  }
}

lint {
  non_linear {
    error   = true
    on_edit = ERROR
  }
}