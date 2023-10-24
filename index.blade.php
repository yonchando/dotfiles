<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>

    @extands('')

    @include('')

    @foreach('')

    @endforeach

    @extends('layout.app')

    @if(true)

    @else

    @endif


    @php
    $count = 0;
    if($count > 0){
    echo "Hello";
    }
    @endphp

    @section('content')

    @endsection

    @section('sidebar')
    <ul>
        <li><a href=""></a></li>
        <li><a href=""></a></li>
        <li><a href=""></a></li>
        <li><a href=""></a></li>
        <li><a href=""></a></li>
    </ul>
    @show

    @section('title')

    @endsection


    @section("")

    @endsection


</body>

</html>
