﻿Shader "Blends/Dissolve"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_DissolvePattern("Dissolve Pattern",2D) = ""{}
		_DissolveThreshold("Dissolve Threshold", Range(0.0,1.0)) = .5
		_HighlightRange("Highlight Range", Range(0,1)) = .1
		_HighlightColor("Highlight Color", Color) = (1,1,1,1)
	}
		SubShader
	{
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent"}
		LOD 100

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			Cull Off
			Lighting Off
			ZWrite Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			sampler2D _DissolvePattern;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}

			float _DissolveThreshold;
			float _HighlightRange;
			fixed4 _HighlightColor;
			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 patternSample = tex2D(_DissolvePattern, i.uv);
				float patternValue = patternSample.r;

				if (patternValue < _DissolveThreshold)
					discard;

				fixed4 col = tex2D(_MainTex, i.uv);
				if (patternValue < _HighlightRange + _DissolveThreshold && patternValue > _DissolveThreshold)
					col *= _HighlightColor;


				return col;

			}
			ENDCG
		}
	}
}
