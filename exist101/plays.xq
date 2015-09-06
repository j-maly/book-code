xquery version "3.0";

(:for $resource in collection("/db/apps/exist101/data") :)
(:return:)
(:  base-uri($resource):)
  
(:<plays>:)
(:{:)
(:  for $resource in collection("/db/apps/exist101/data") :)
(:    return <play uri="{base-uri($resource)}"/>:)
(:}:)
(:</plays>:)
 
(:<plays>:)
(:{:)
(:    for $resource in collection("/db/apps/exist101/data"):)
(:    return :)
(:        <play uri="{base-uri($resource)}":)
(:          name="{util:unescape-uri(replace(base-uri($resource), :)
(:            ".+/(.+)$", "$1"), "UTF-8")}">:)
(:        {:)
(:            $resource/PLAY/TITLE/text():)
(:        }:)
(:        </play>:)
(:}:)
(:</plays>:)

(:declare option exist:serialize "method=xhtml media-type=text/html";:)
(:<html>:)
(:    <head>:)
(:        <meta HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"/>:)
(:        <title>Our Shakespeare plays</title>:)
(:    </head>:)
(:    <body>:)
(:        <h1>Our Shakespeare plays</h1>:)
(:    </body>:)
(:</html>:)

declare option exist:serialize "method=xhtml media-type=text/html";
declare variable $page-title := "Our Shakespeare plays";
let $play-info :=
    <plays>
    {
        for $resource in collection('/db/apps/exist101/data') 
        return 
            <play uri="{base-uri($resource)}"
                name="{util:unescape-uri(replace(base-uri($resource),
                ".+/(.+)$", "$1"), "UTF-8")}">
            {
                $resource/PLAY/TITLE/text()
            }
            </play>
    }
    </plays>
return  
  
    <html>
        <head>
            <meta HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"/>
            <title>{$page-title}</title>
        </head>
        <body>
            <h1>{$page-title}</h1>
            <ul>
            {
                for $play in $play-info/play
                return
                <li>{string($play)} ({string($play/@name)})</li>
            }
            </ul>
        </body>
    </html>