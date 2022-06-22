{
  inputs,
  cell,
}: let
  inherit (inputs.grafonnix.lib) alertCondition alertlist;
in {
  example =
    (alertCondition.new {
      evaluatorType = "within_range";
      evaluatorParams = [1234 4321];
      operatorType = "or";
      reducerType = "diff";
      queryRefId = "B";
      queryTimeStart = "15m";
      queryTimeEnd = "now-1h";
    })
    .__unpop__;

  list =
    (alertlist.new {
      title = "Alerts List";
      datasource = "$PROMETHEUS";
      description = "description";
      span = 5;
      show = "current";
      limit = 20;
      sortOrder = 2;
      stateFilter = [
        "ok"
        "pending"
      ];
      onlyAlertsOnDashboard = true;
      transparent = true;
    })
    .__unpop__;
}
