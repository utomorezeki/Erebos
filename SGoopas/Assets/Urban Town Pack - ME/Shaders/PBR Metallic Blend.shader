// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "FlamingSands/PBR Metallic Blend"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Albedo("Albedo", 2D) = "white" {}
		_Glossiness("Glossiness", Float) = 1
		_Metallic("Metallic", Float) = 1
		_RMA("RMA", 2D) = "white" {}
		_NormalIntensity("Normal Intensity", Float) = 1
		_Normal("Normal", 2D) = "bump" {}
		_Albedo2("Albedo 2", 2D) = "white" {}
		_RMA2("RMA 2", 2D) = "white" {}
		_Normal2("Normal 2", 2D) = "bump" {}
		_Tiling("Tiling", Float) = 1
		_Height("Height", 2D) = "white" {}
		_HeightContrast("Height Contrast", Float) = 1
		[Toggle]_RoundHeight("Round Height", Float) = 0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 texcoord_0;
			float4 vertexColor : COLOR;
		};

		uniform float _NormalIntensity;
		uniform sampler2D _Normal2;
		uniform float _Tiling;
		uniform sampler2D _Normal;
		uniform float _RoundHeight;
		uniform sampler2D _Height;
		uniform float _HeightContrast;
		uniform sampler2D _Albedo2;
		uniform sampler2D _Albedo;
		uniform sampler2D _RMA2;
		uniform sampler2D _RMA;
		uniform float _Metallic;
		uniform float _Glossiness;


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue, 0, 0, 0,0,contrastValue, 0, 0,0,0,contrastValue, 0,t, t, t, 1 ), colorTarget );
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 temp_cast_0 = (_Tiling).xx;
			o.texcoord_0.xy = v.texcoord.xy * temp_cast_0 + float2( 0,0 );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 temp_cast_0 = (_HeightContrast).xxxx;
			float4 temp_output_75_0 = clamp( CalculateContrast(clamp( ( ( tex2D( _Height,i.texcoord_0).r - 1.0 ) + ( i.vertexColor.r * 2.0 ) ) , 0.0 , 1.0 ),temp_cast_0) , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			float4 temp_cast_1 = (_HeightContrast).xxxx;
			float componentMask51 = lerp(temp_output_75_0,round( temp_output_75_0 ),_RoundHeight).r;
			float temp_output_89_0 = ( 1.0 - componentMask51 );
			o.Normal = lerp( UnpackScaleNormal( tex2D( _Normal2,i.texcoord_0) ,_NormalIntensity ) , UnpackScaleNormal( tex2D( _Normal,i.texcoord_0) ,_NormalIntensity ) , temp_output_89_0 );
			o.Albedo = lerp( tex2D( _Albedo2,i.texcoord_0) , tex2D( _Albedo,i.texcoord_0) , temp_output_89_0 ).rgb;
			o.Metallic = ( lerp( tex2D( _RMA2,i.texcoord_0) , tex2D( _RMA,i.texcoord_0) , temp_output_89_0 ).g * _Metallic );
			o.Smoothness = ( lerp( tex2D( _RMA2,i.texcoord_0) , tex2D( _RMA,i.texcoord_0) , temp_output_89_0 ).r * _Glossiness );
			o.Occlusion = lerp( tex2D( _RMA2,i.texcoord_0) , tex2D( _RMA,i.texcoord_0) , temp_output_89_0 ).b;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=7003
-1913;29;1906;1004;1600.713;1071.809;1.3;True;True
Node;AmplifyShaderEditor.RangedFloatNode;76;-3282.4,-333.6;Float;False;Property;_Tiling;Tiling;9;0;1;0;0;FLOAT
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-3042.4,-269.6;Float;False;0;-1;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;36;-2177.703,-920.8997;Float;True;Property;_Height;Height;10;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;69;-1970.616,-448.3152;Float;False;Constant;_Float0;Float 0;16;0;2;0;0;FLOAT
Node;AmplifyShaderEditor.VertexColorNode;37;-2146.503,-646.3999;Float;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;70;-1758.017,-719.5148;Float;False;Constant;_Float1;Float 1;16;0;1;0;0;FLOAT
Node;AmplifyShaderEditor.SimpleSubtractOpNode;67;-1589.016,-755.5148;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-1556.016,-597.5148;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;71;-1345.016,-716.5148;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;74;-1173.016,-620.5148;Float;False;Property;_HeightContrast;Height Contrast;11;0;1;0;0;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;72;-1127.016,-743.5148;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleContrastOpNode;73;-921.0153,-702.5148;Float;False;0;FLOAT;0.0;False;1;COLOR;0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.ClampOpNode;75;-654.0146,-717.5148;Float;False;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;COLOR
Node;AmplifyShaderEditor.RoundOpNode;66;-558.8124,-914.5159;Float;False;0;COLOR;0.0;False;COLOR
Node;AmplifyShaderEditor.ToggleSwitchNode;88;-382.8123,-948.2081;Float;False;Property;_RoundHeight;Round Height;12;1;[Toggle];0;0;COLOR;0.0;False;1;COLOR;0.0;False;COLOR
Node;AmplifyShaderEditor.ComponentMaskNode;51;-206.6988,-724.9013;Float;False;True;False;False;False;0;COLOR;0,0,0,0;False;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;89;-377.6138,-390.5095;Float;False;0;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SamplerNode;80;-985.2155,738.2877;Float;True;Property;_RMA2;RMA 2;7;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;32;-944,-96;Float;True;Property;_RMA;RMA;3;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;9;-1536.5,656;Float;False;Property;_NormalIntensity;Normal Intensity;4;0;1;0;0;FLOAT
Node;AmplifyShaderEditor.LerpOp;84;-346.3156,342.0886;Float;False;0;COLOR;0.0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0;False;COLOR
Node;AmplifyShaderEditor.SamplerNode;79;-985.2155,528.6877;Float;True;Property;_Albedo2;Albedo 2;6;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.BreakToComponentsNode;85;-147.5153,194.789;Float;False;COLOR;0;COLOR;0.0;False;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;7;-896,304;Float;True;Property;_Normal;Normal;5;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;1;-944,-304;Float;True;Property;_Albedo;Albedo;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;81;-992,960;Float;True;Property;_Normal2;Normal 2;8;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;13;-896,110.7;Float;False;Property;_Glossiness;Glossiness;1;0;1;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;2;-896,192;Float;False;Property;_Metallic;Metallic;2;0;1;0;0;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;203.6,104.8999;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;200.6,3.899991;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.LerpOp;82;0,-160;Float;False;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0;False;COLOR
Node;AmplifyShaderEditor.LerpOp;83;-176,496;Float;False;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0.0;False;FLOAT3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;713.0997,-134.5999;Float;False;True;2;Float;ASEMaterialInspector;0;Standard;FlamingSands/PBR Metallic Blend;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;OBJECT;0.0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False
WireConnection;29;0;76;0
WireConnection;36;1;29;0
WireConnection;67;0;36;1
WireConnection;67;1;70;0
WireConnection;68;0;37;1
WireConnection;68;1;69;0
WireConnection;71;0;67;0
WireConnection;71;1;68;0
WireConnection;72;0;71;0
WireConnection;73;0;72;0
WireConnection;73;1;74;0
WireConnection;75;0;73;0
WireConnection;66;0;75;0
WireConnection;88;0;75;0
WireConnection;88;1;66;0
WireConnection;51;0;88;0
WireConnection;89;0;51;0
WireConnection;80;1;29;0
WireConnection;32;1;29;0
WireConnection;84;0;80;0
WireConnection;84;1;32;0
WireConnection;84;2;89;0
WireConnection;79;1;29;0
WireConnection;85;0;84;0
WireConnection;7;1;29;0
WireConnection;7;5;9;0
WireConnection;1;1;29;0
WireConnection;81;1;29;0
WireConnection;81;5;9;0
WireConnection;33;0;85;1
WireConnection;33;1;2;0
WireConnection;12;0;85;0
WireConnection;12;1;13;0
WireConnection;82;0;79;0
WireConnection;82;1;1;0
WireConnection;82;2;89;0
WireConnection;83;0;81;0
WireConnection;83;1;7;0
WireConnection;83;2;89;0
WireConnection;0;0;82;0
WireConnection;0;1;83;0
WireConnection;0;3;33;0
WireConnection;0;4;12;0
WireConnection;0;5;85;2
ASEEND*/
//CHKSM=C3F63B719FAB2747C4CCF6C3E576F2B09B967495