# frozen_string_literal: true

# Module containing functions that has formatted strings to display in a message
module TextLib
  SPECIAL_CHARS = ['$', '\\', '#', '{', '}'].freeze

  def hydrate_call(mentioned_users)
    <<-HYDRATE
    #{mentioned_users}

    You are called by the hydration nation,
    to keep yourself hydrated!
    ```
      ,--,           ,--,
      )""(           )""(
     /    \\         .%nn%.
    /      \\       /%%%%%%\\
    .        .    .%%%%%%%%.
    |`-....-'|    |"*%%%%*"|
    |        |    |        |
    |        |    |        |
    |`-....-'|    |8n....n8|
    |        |    |%%%%%%%%|
    |        |    |%%%%%%%%|
    `-....-' mh   "*%%%%*" mh

    )_)     _ ) _ _  _)_ o  _   _#{'  '}
    ( ( (_( (_( ) (_( (_  ( (_) ) )#{' '}
          _)#{'                        '}
    #{'                                '}
    )\\ ) _  _)_ o  _   _#{'           '}
    (  ( (_( (_  ( (_) ) )#{'          '}
    #{'                    '}
    ```
    HYDRATE
  end
end
