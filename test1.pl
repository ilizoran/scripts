#!/usr/bin/perl

$to = 'zilibasic@s7designcreative.com';
use MIME::Lite;

# $msg = MIME::Lite->new (
#   From =>'zilibasic@s7designcreative.com',
#   To => 'vmajkic@s7designcreative.com',
#   Subject => "Test",
#   Type =>'multipart/mixed'
# ) or die "$!\n";

# ### Add the ZIP file
# $msg->attach (
#    Type => 'application/zip',
#    Path => '/opt/scripts/test.zip',
#    Filename => 'SomeFile.zip',
#    Disposition => 'attachment'
# ) or die "Error adding File.zip: $!\n";



    # $msg = MIME::Lite->new(
    #     From =>'zilibasic@s7designcreative.com',
    #     To => 'vmajkic@s7designcreative.com',
    #     Subject => "Test",
    #     Subject  =>'Helloooooo!!!!',
    #     Type     =>'image/png',
    #     Encoding =>'base64',
    #     Path     =>'/opt/scripts/test.png'
    # );


### Create the multipart "container":
    # $msg = MIME::Lite->new(
    #     From =>'zilibasic@s7designcreative.com',
    #     To => 'vmajkic@s7designcreative.com',
    #     Subject => "Test",
    #     Type    =>'multipart/mixed'
    # );

    # ### Add the text message part:
    # ### (Note that "attach" has same arguments as "new"):
    # $msg->attach(
    #     Type     =>'TEXT',
    #     Data     =>"Here's the PNG file you wanted"
    # );

    # ### Add the image part:
    # $msg->attach(
    #     Type        =>'image/png',
    #     Path        =>'/opt/scripts/test.png',
    #     Filename    =>'logo.png',
    #     Disposition => 'attachment'
    # );


### Start with a simple text message:
    # $msg = MIME::Lite->new(
    #     From =>'zilibasic@s7designcreative.com',
    #     To => 'vmajkic@s7designcreative.com',
    #     Subject => "Test",
    #     Type    =>'TEXT',
    #     Data    =>"Here's the PNG file you wanted"
    # );

    # ### Attach a part... the make the message a multipart automatically:
    # $msg->attach(
    #     Type     =>'image/png',
    #     Path     =>'/opt/scripts/test.png',
    #     Filename =>'test123.png'
    # );
##### HTML

$msg = MIME::Lite->new(
        From =>'zilibasic@s7designcreative.com',
        To => 'vmajkic@s7designcreative.com',
        Subject => "Test",
        Type    =>'multipart/related'
    );
    $msg->attach(
        Type => 'text/html',
        Data => qq{
            <body>
                <p>Click following link</p>
                <a href="http://www.tutorialspoint.com" target="_self">Tutorials Point</a>
                <ul>
                        <li>Beetroot</li>
                        <li>Ginger</li>
                        <li>Potato</li>
                        <li>Radish</li>
                </ul>

                <table border="1">
                        <tr>
                                <td>Row 1, Column 1</td>
                                <td>Row 1, Column 2</td>
                        </tr>
                        <tr>
                                <td>Row 2, Column 1</td>
                                <td>Row 2, Column 2</td>
                        </tr>
                </table>
            </body>
        },
    );

    $msg->send();


##### HTML with image

# $msg = MIME::Lite->new(
#         From =>'zilibasic@s7designcreative.com',
#         To => 'vmajkic@s7designcreative.com',
#         Subject => "Test",
#         Type    =>'multipart/related'
#     );
#     $msg->attach(
#         Type => 'text/html',
#         Data => qq{
#             <body>
#                 Here's <i>my</i> image:
#                 <img src="cid:myimage.gif">
#             </body>
#         },
#     );
#     $msg->attach(
#         Type => 'image/gif',
#         Id   => 'myimage.gif',
#         Path => '/opt/scripts/test.png',
#     );
#     $msg->send();


### Send the Message
$msg->send('smtp', 'mail.s7designcreative.com', Timeout=>60);
