Path =
  # This is a wrapper for the routers navigation function.
  # One of the design requirements is that the accounts package
  # cannot depend on the FlowRouter package directly.
  go: (location)-> FlowRouter.go(location)
