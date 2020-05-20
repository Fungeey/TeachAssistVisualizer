// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/ColorMask"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_MaskColor1("Dark Color", Color) = (1,1,1,1)
		_MaskColor2("Light", Color) = (1,1,1,1)
		_MaskColor3("Line", Color) = (1,1,1,1)
		_Black("Black", Color) = (1,1,1,1)
	}
	SubShader {
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		LOD 100
    
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha 
	
     
		Pass {  
			CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_fog
            
				#include "UnityCG.cginc"
 
				struct appdata_t {
					float4 vertex : POSITION;
					float2 texcoord : TEXCOORD0;
				};
 
				struct v2f {
					float4 vertex : SV_POSITION;
					half2 texcoord : TEXCOORD0;
					UNITY_FOG_COORDS(1)
				};
 
				sampler2D _MainTex;
				float4 _MainTex_ST;
				float4 _MaskColor1;
				float4 _MaskColor2;
				float4 _MaskColor3;
				float4 _Black;
            
				v2f vert (appdata_t v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
					UNITY_TRANSFER_FOG(o,o.vertex);
					return o;
				}
            
				fixed4 frag (v2f i) : SV_Target
				{
					fixed4 col = tex2D(_MainTex, i.texcoord);
				
					fixed4 delta = abs(col - _MaskColor1);
					fixed4 rgb = length(delta) < 0.1 ? col : fixed4(0, 0, 0, 0);
					
					delta = abs(col - _MaskColor2);
					rgb = length(delta) < 0.1 ? col : rgb;
					
					delta = abs(col - _MaskColor3);
					rgb = length(delta) < 0.1 ? col : rgb;

					delta = abs(col - _Black);
					rgb = length(delta) < 0.1 ? col : rgb;

					return rgb;
				}
			ENDCG
		}
	}
}
