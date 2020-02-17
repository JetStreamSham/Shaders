Shader "Blends/TextureBlend"
{
    Properties
    {
		_Texture1("Color1", 2D) = ""{}
		_Texture2("Color2", 2D) = ""{}
		_Blend ("Blend", Range(0,1)) = .5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#include "UnityCG.cginc"


            struct appdata
            {
                float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float2 uv2 : TEXCOORD1;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				float2 uv2 : TEXCOORD1;
            };

            sampler2D _Texture1;
            sampler2D _Texture2;

			float4 _Texture1_ST;
			float4 _Texture2_ST;
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _Texture1);
				o.uv2 = TRANSFORM_TEX(v.uv2, _Texture2);
                return o;
            }
			float _Blend;
			fixed4 frag(v2f i) : SV_Target
			{
				// sample the texture
				fixed4 texSample1 = tex2D(_Texture1,i.uv);
				fixed4 texSample2 = tex2D(_Texture2,i.uv2);
				fixed4 col = lerp(texSample1, texSample2,_Blend);
                return col;
            }
            ENDCG
        }
    }
}
